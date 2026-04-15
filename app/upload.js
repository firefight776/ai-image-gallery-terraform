document.addEventListener('DOMContentLoaded', () => {
    console.log('upload.js loaded');
  
    const FUNCTION_URL = "https://md3iojbo62bzo5y6j6236rsbii0jhuce.lambda-url.us-east-1.on.aws"; // no trailing slash
  
    // Show chosen filename
    document.getElementById('imageUpload').addEventListener('change', (e) => {
      const f = e.target.files[0];
      document.querySelector('.custom-file-label').textContent = f ? f.name : 'Choose file';
    });
  
    // Handle submit
    document.getElementById('upload-form').addEventListener('submit', (e) => {
      e.preventDefault();
      console.log('submit fired');
  
      const spinner = document.getElementById('spinner');
      const msg = document.getElementById('message');
      const file = document.getElementById('imageUpload').files[0];
  
      msg.innerHTML = '';
      if (!file) {
        alert('Please select a file to upload.');
        return;
      }
  
      spinner.style.display = 'block';
      const contentType = file.type || 'application/octet-stream';
      console.log('calling presign...', contentType);
  
      // 1) Get presigned URL from Lambda (NOTE: content-type param name)
      fetch(`${FUNCTION_URL}/generate-presigned-url?content-type=${encodeURIComponent(contentType)}`)
        .then(r => {
          if (!r.ok) throw new Error(`Presign HTTP ${r.status}`);
          return r.json();
        })
        .then(data => {
          const uploadUrl = data.upload_url || data.url;
          const extraHeaders = data.headers || {};
          if (!uploadUrl) throw new Error('Presign response missing URL');
  
          // 2) Upload file to S3 with the SAME Content-Type
          return fetch(uploadUrl, {
            method: 'PUT',
            headers: { 'Content-Type': contentType, ...extraHeaders },
            body: file
          });
        })
        .then(up => {
          spinner.style.display = 'none';
          if (!up.ok) throw new Error(`Upload failed: ${up.status}`);
          msg.innerHTML = `<div class="alert alert-success" role="alert">File "${file.name}" successfully uploaded.</div>`;
          document.getElementById('upload-form').reset();
          document.querySelector('.custom-file-label').textContent = 'Choose file';
        })
        .catch(err => {
          console.error('Upload flow error:', err);
          spinner.style.display = 'none';
          msg.innerHTML = `<div class="alert alert-danger" role="alert">${err.message || 'Error fetching pre-signed URL.'}</div>`;
        });
    });
  });
  