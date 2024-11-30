// see https://developers.cloudflare.com/r2/examples/demo-worker/

interface Env {
    DOWNLOADS_BUCKET: R2Bucket
}

const allowedPrefixes = [
    'LyrionMusicServer_v.*',
    'LogitechMediaServer_v.*',
    'SqueezeboxServer_v.*',
    'SqueezeCenter_v.*',
    'SlimServer_v.*',
    'SLIMP3_Server_v.*',
]

const corsHeaders = {
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "GET, OPTIONS, HEAD",
    "Access-Control-Max-Age": "86400",
}


export default {
    async fetch(request, env): Promise<Response> {
        const url = new URL(request.url)
        const prefix = url.pathname.slice(1)

        if (!prefix) {
            return Response.redirect('https://lyrion.org/getting-started')
        }

        if (request.method === 'GET' && prefix && allowedPrefixes.some(p => new RegExp(p).test(prefix))) {
            const listing = await env.DOWNLOADS_BUCKET.list({ prefix })

            // we only want object with the given prefix, but no sub-folders
            const filterRe = new RegExp(prefix + (prefix.match(new RegExp("/$")) ? "" : "/") + "[^\/]+$")

            const body = listing.objects
                .filter(i => filterRe.test(i.key))
                .map(i => ({
                    key: i.key,
                    size: i.size,
                }))

            return new Response(JSON.stringify(body), {
                headers: {
                    ...corsHeaders,
                    'Access-Control-Allow-Headers': request.headers.get(
                      "Access-Control-Request-Headers",
                    ) || '',
                    'content-type': 'application/json; charset=UTF-8',
                }
            })
        }

        // we don't want to reveal a path doesn't exist - return valid, but empty result set
        return new Response('[]', {
            headers: {
                'content-type': 'application/json; charset=UTF-8',
            }
        })
    }
} satisfies ExportedHandler<Env>