---
layout: default
title: Downloads Archive
---

!!! warning
    These files are unsupported. Many documents are outdated, software packages might not work any more. Use at your own risk.

[Go back to safety, get the latest release](../getting-started/index.md).

<script>
    /**
     * this client side JavaScript dynamically renders the lists of archived content
     * by fetching a file list from R2
     */
    async function fetchAndRender(prefix) {
        // get list of objects with given prefix
        let releaseData = [];
        try {
            const response = await fetch('https://lms-downloads-handler.lyrion.workers.dev/' + prefix);
            releaseData = await response.json();
        }
        catch(e) {
            console.warn(e);
        }

        document.getElementById("loading-indicator").style.display = "none";

        // read rendered icons into variables - we can't have icon placeholders in JS code
        const icons = Array.from(document.querySelectorAll('.icon'))
            .reduce((prev, cur) => {
                return {
                    ...prev,
                    [cur.classList[1]]: cur.innerHTML
                };
            }, {});

        // keep in sync with tools/build-server-downloads-page.pl
        const win32 = `<td>${icons.windows} Windows 32-bit</td>`;
        const win64 = win32.replace('32-', '64-');
        const winhs = win32.replace('32-bit', 'Home Server');
        const macos = `<td>${icons.apple} Apple macOS</td>`;
        const deb = `<td>${icons.debian} Debian / ${icons.ubuntu} Ubuntu i386, x86_64, ARM</td>`;
        const debamd64 = deb.replace(', ARM', '').replace('i386, ', '');
        const debi386 = deb.replace('x86_64, ', '').replace(', ARM', '');
        const debarm = deb.replace('x86_64, ', '').replace('i386, ', '');
        const rpm = `<td>${icons.redhat} Red Hat / ${icons.fedora} Fedora / ${icons.linux} other RPM-based distribution</td>`;
        const nocpan = `<td>${icons.linux}${icons.source} Linux/Unix Tarball - No CPAN Libraries</td>`;
        const zipball = nocpan.replace('Tarball', 'ZIP Archive');
        const encore = `<td>${icons.linux}${icons.encore} Musical Fidelity</td>`;
        const tarball = `<td>${icons.linux}${icons.source} Linux/Unix Tarball - i386, x86_64, i386 FreeBSD, ARM</td>`;
        const tararm = `<td>${icons.linux}${icons.source} Linux Tarball - ARM</td>`;
        const readynas = `<td>${icons.linux} Netgear ReadyNAS (legacy)</td>`;

        // firmware files
        const sbFirmware = `<td>${icons.firmware} Squeezebox Firmware</td>`;
        const versionFile = `<td>${icons.version} Version file</td>`;
        const sha = `<td>${icons.checksum} Checksum file</td>`;
        const pdf = `<td>${icons.pdf} Adobe PDF document</td>`;
        const image = `<td>${icons.image} Image file</td>`;

        let tableRows = '';

        // render table rows for the various objects
        releaseData.forEach(item => {
            let fileType = '<td></td>';
            if (item.key.endsWith('win64.exe')) fileType = win64;
            else if (item.key.endsWith('perlscripts.ZIP')) fileType = zipball;
            else if (item.key.endsWith('.exe') || item.key.endsWith('.ZIP')) fileType = win32;
            else if (item.key.endsWith('.msi')) fileType = winhs;
            else if (item.key.endsWith('.pkg') || item.key.endsWith('.dmg')) fileType = macos;
            else if (item.key.endsWith('amd64.deb')) fileType = debamd64;
            else if (item.key.endsWith('arm.deb')) fileType = debarm;
            else if (item.key.endsWith('i386.deb')) fileType = debi386;
            else if (item.key.endsWith('.deb')) fileType = deb;
            else if (item.key.endsWith('.rpm')) fileType = rpm;
            else if (item.key.endsWith('noCPAN.tgz') || item.key.endsWith('no-cpan-arch.tar.gz')) fileType = nocpan;
            else if (item.key.endsWith('MusicalFidelity.tgz')) fileType = encore;
            else if (item.key.endsWith('arm-linux.tgz')) fileType = tarball;
            else if (item.key.endsWith('.tgz') || item.key.endsWith('.tar.gz')) fileType = tararm;
            else if (item.key.endsWith('readynas.bin')) fileType = readynas;

            // firmware
            else if (/(fab4|baby|boom|jive|receiver|squeezebox|transporter).*(\d+)?.*\.bin$/.test(item.key)) fileType = sbFirmware;
            else if (item.key.endsWith('.version')) fileType = versionFile;
            else if (item.key.endsWith('version.sha') || item.key.endsWith('bin.sha')) fileType = sha;

            // other file types
            else if (item.key.endsWith('.pdf')) fileType = pdf;
            else if (/\.(jpe?g|gif|png)$/.test(item.key)) fileType = image;

            tableRows = tableRows + `<tr>
                <td><a href="https://downloads.lms-community.org/${item.key}">${item.key.split('/').pop()}</a></td>
                <td style="text-align: right;">${formatFileSize(item.size)}</td>
                ${fileType}
            </tr>`
        });

        function formatFileSize(bytes) {
            if (1024 > bytes) return bytes + ' Bytes';
            else if (1024*1024 < bytes) return Math.trunc(bytes/1024/1024) + ' MB';

            return Math.trunc(bytes/1024) + ' KB';
        }

        const table = document.querySelector('#downloads');
        table.innerHTML = tableRows || '<tr><td colspan=3>No files found.</td></tr>';
    }

    fetchAndRender(document.location.search.replace('?', ''))
</script>

<style>
    /* https://css-loaders.com/dots/ */
    .loader {
        width: 30px;
        aspect-ratio: 2;
        --_g: no-repeat radial-gradient(circle closest-side,var(--md-default-fg-color) 90%,#0000);
        background:
            var(--_g) 0%   50%,
            var(--_g) 50%  50%,
            var(--_g) 100% 50%;
        background-size: calc(100%/3) 50%;
        animation: l3 1s infinite linear;
    }

    @keyframes l3 {
        20%{background-position:0%   0%, 50%  50%,100%  50%}
        40%{background-position:0% 100%, 50%   0%,100%  50%}
        60%{background-position:0%  50%, 50% 100%,100%   0%}
        80%{background-position:0%  50%, 50%  50%,100% 100%}
    }
</style>

<table>
    <thead>
        <tr>
            <th>Name</th>
            <th style="text-align: right;">Size</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody id="downloads">
    </tbody>
</table>

<!-- render (hidden) icons to be picked up in the JS code above -->
<span style="display:none">
    <span class="icon apple">:material-apple:</span>
    <span class="icon source">:material-code-braces:</span>
    <span class="icon debian">:material-debian:</span>
    <span class="icon docker">:material-docker:</span>
    <span class="icon encore">:material-music-box:</span>
    <span class="icon fedora">:material-fedora:</span>
    <span class="icon linux">:material-linux:</span>
    <span class="icon redhat">:material-redhat:</span>
    <span class="icon ubuntu">:material-ubuntu:</span>
    <span class="icon windows">:material-microsoft-windows:</span>
    <span class="icon firmware">:material-file-download-outline:</span>
    <span class="icon version">:material-file-outline:</span>
    <span class="icon checksum">:material-file-check-outline:</span>
    <span class="icon pdf">:material-file-pdf-box:</span>
    <span class="icon image">:material-image:</span>
</span>

<div id="loading-indicator" class="loader"></div>
