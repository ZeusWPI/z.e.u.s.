const fileInput = document.querySelector('#upload input');
const selectedFiles = document.getElementById('selectedFiles');
const form = document.getElementById('upload');
const uploadList = document.getElementById('uploadList');


form.addEventListener('submit', (event) => {
    event.preventDefault();

    uploadFiles();
})

function uploadFiles() {
    for (file of fileInput.files) {
        console.log(file);
        uploadFile(file);
    }

    //document.location = form.getAttribute('action');
}

function uploadFile(file) {
    const card = document.createElement('div');
    const cardContent = document.createElement('div');
    const progressBar = document.createElement('progress');

    card.classList = 'card';
    cardContent.classList = 'card-content';
    //cardContent.innerText = file.name;
    progressBar.classList = 'progress';
    progressBar.setAttribute('value',  0);
    progressBar.setAttribute('max', file.size);
    cardContent.appendChild(progressBar);
    card.appendChild(cardContent);

    uploadList.insertBefore(card, uploadList.firstChild);

    const formdata = new FormData();
    const request = new XMLHttpRequest();

    formdata.append('file', file);

    request.upload.addEventListener('progress', (e) => {
        progressBar.setAttribute('value', e.loaded);
    });

    request.onload = event => {
        if (request.status != 200) {
            progressBar.classList += ' is-danger';
        }
    }

    request.open('post', document.location);
    request.timeout = 45000;
    request.send(formdata);
}


fileInput.onchange = () => {
    selectedFiles.querySelector('span').innerText = `Selected ${fileInput.files.length} files for upload.`
    selectedFiles.removeAttribute('hidden');
};