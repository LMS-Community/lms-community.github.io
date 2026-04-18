export default {
  async fetch(request: Request, env: any) {
    let url = new URL(request.url);
    let key = url.pathname.slice(1); // remove leading "/"

    // If path ends with "/", append index.html
    if (key === '' || key.endsWith("/")) {
      key += "index.html";
    }

    // Optional: also handle paths without extension
    if (!key.includes(".")) {
      key += "/index.html";
    }

    const object = await env.PREVIEW.get(key);

    if (!object) {
      return new Response("Not Found", { status: 404 });
    }

    return new Response(object.body, {
      headers: {
        "Content-Type": object.httpMetadata?.contentType || "text/html",
        "Cache-Control": "public, max-age=3600",
      },
    });
  }
};