import { Hono, Context } from 'hono'
import { cors } from 'hono/cors'

interface Env {
    BUGS_DB: D1Database;
}

const app = new Hono()

app.use('*', cors())

app.get('/search', async (c: Context, ) => {
    const query = c.req.query('q')
    const extended = c.req.query('x')

    if (!query) return c.json({})

    const sql = extended
        ? `
            SELECT file, SNIPPET(bugs, 2, '<b>', '</b>', '...', 30) AS snippet
            FROM bugs
            WHERE bugs MATCH ?
            ORDER BY rank
        `
        : 'SELECT file FROM bugs WHERE bugs MATCH ? ORDER BY rank'

    const { results } = await c.env.BUGS_DB.prepare(sql).bind(query).all()

    return c.json({ results: results.map(extended
        ? (r: any) => ([ r.file, r.snippet ])
        : (r: any) => r.file)
    })
})

export default app
