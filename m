Content-Type: multipart/mixed; boundary="===============9161405181237052542=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: [PATCH 3/4] Bearer documentation
Date: Tue, 11 Jan 2011 09:53:34 +0200
Message-ID: <1294732414.5651.1131.camel@tucson>
In-Reply-To: <1294705583.3873.3.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9161405181237052542==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Mon, 2011-01-10 at 16:26 -0800, ext Marcel Holtmann wrote:
> As Denis said, the vendor commands indicate that it is a global bearer
> information. If one context is on HSPA, then others will be as well. So
> how does ISI provide this information? Is it globally or per context?

I doubt contexts can even be on different bearers. At least on ISI, the
indication for HS*PA channel allocations is global, and so is cell
supported technologies.

Cheers,
Aki


--===============9161405181237052542==--

