Content-Type: multipart/mixed; boundary="===============3171233101400470500=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH 10/16] gprs: Add ofono_gprs_create_context method
Date: Fri, 13 Aug 2010 15:04:35 +0200
Message-ID: <1281704675.23399.11.camel@localhost.localdomain>
In-Reply-To: <33AB447FBD802F4E932063B962385B3528F0C587@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3171233101400470500==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> >> DUN server may create one primary context if none of contexts
> >> existing on the GPRS atom.
> > =

> > so Denis and I had a chat about this. And we agreed that oFono core
> > should just create one Internet context if none exists. If the plugin
> > driver registers a GPRS atom, we should just create one context
> > anyway. ConnMan requires this anyway and it makes sense. We can also
> > go one step ahead and fail to remove this default Internet context.
> > It should be present all the time.
> =

> Thanks for update. I will update my patch to keep this context alive after
> DUN client disconnect from us.

actually can you just work on a separate patch that just create a
default context when the GPRS atom is supported. We should add this
support first and don't tie it to DUN support.

Regards

Marcel



--===============3171233101400470500==--

