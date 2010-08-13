Content-Type: multipart/mixed; boundary="===============8953623516018719968=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: [PATCH 10/16] gprs: Add ofono_gprs_create_context method
Date: Fri, 13 Aug 2010 09:42:35 +0800
Message-ID: <33AB447FBD802F4E932063B962385B3528F0C587@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <1281614258.12579.272.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8953623516018719968==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

Marcel Holtmann wrote:
> Hi Zhenhua,
> =

>> DUN server may create one primary context if none of contexts
>> existing on the GPRS atom.
> =

> so Denis and I had a chat about this. And we agreed that oFono core
> should just create one Internet context if none exists. If the plugin
> driver registers a GPRS atom, we should just create one context
> anyway. ConnMan requires this anyway and it makes sense. We can also
> go one step ahead and fail to remove this default Internet context.
> It should be present all the time.

Thanks for update. I will update my patch to keep this context alive after
DUN client disconnect from us.

> Regards
> =

> Marcel
> =

> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

Regards,
Zhenhua

--===============8953623516018719968==--

