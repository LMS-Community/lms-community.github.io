---
layout: default
title: Downloads Archive
---

!!! warning
    These releases are unsupported. Many probably don't work any more. Use at your own risk.

[Go back to safety, get the latest release](../getting-started/index.md).

<script>
    /**
     * this client side JavaScript dynamically renders the lists of archived content
     * by fetching a file list from R2
     */
    async function fetchAndRender(prefix) {
        // get list of objects with given prefix
        const response = await fetch('https://lms-downloads-handler.lyrion.workers.dev/' + prefix);
        const releaseData = await response.json();

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

            tableRows = tableRows + `<tr>
                <td><a href="https://downloads.lms-community.org/${item.key}">${item.key.split('/').pop()}</a></td>
                <td style="text-align: right;">${Math.trunc(item.size/1024/1024)} MB</td>
                ${fileType}
            </tr>`
        });

        const table = document.querySelector('#downloads');
        table.innerHTML = tableRows;
    }

    fetchAndRender(document.location.search.replace('?', ''))
</script>

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
</span>
