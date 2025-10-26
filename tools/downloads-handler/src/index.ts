import { Hono, Context } from 'hono'

const DEBUG = false
const urlPrefix = 'downloads/listing/archive';

interface Env {
    DOWNLOADS_BUCKET: R2Bucket
}

const allowedPrefixes: Array<string> = [
    'LyrionMusicServer_v.*',
    'LogitechMediaServer_v.*',
    'SqueezeboxServer_v.*',
    'SqueezeCenter_v.*',
    'SlimServer_v.*',
    'SLIMP3_Server_v.*',
    'update/firmware/*',
    'docs/*',
]

const corsHeaders: Record<string, string> = {
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "GET, OPTIONS, HEAD",
    "Access-Control-Max-Age": "86400",
}

const app = new Hono()

app.get(`/${urlPrefix}/:prefix{.*}`, async (c: Context, ) => {
    const prefix = c.req.param('prefix');

    DEBUG && console.log(prefix)

    if (!prefix) {
        return Response.redirect('https://lyrion.org/getting-started')
    }

    if (prefix && allowedPrefixes.some(p => new RegExp(p).test(prefix))) {
        const listing = await c.env.DOWNLOADS_BUCKET.list({ prefix })

        // we only want objects with the given prefix, but no sub-folders
        const filterRe = new RegExp(prefix + (prefix.match(new RegExp("/$")) ? "" : "/") + "[^\/]+$")

        const body = listing.objects
            .filter((i: any) => filterRe.test(i.key))
            .map((i: any) => ({
                key: i.key,
                size: i.size,
            }))

        Object.keys(corsHeaders).forEach(key => {
            c.header(key, corsHeaders[key]);
        })

        c.header('Access-Control-Allow-Headers', c.req.header(
            "Access-Control-Request-Headers",
        ) || '')

        return c.json(body)
    }

    // we don't want to reveal a path doesn't exist - return valid, but empty result set
    return new Response('[]', {
        headers: {
            'content-type': 'application/json; charset=UTF-8',
        }
    })
})

export default app
