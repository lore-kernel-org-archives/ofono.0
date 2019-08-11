Content-Type: multipart/mixed; boundary="===============8480390280411676989=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] gprs: Ignore activated contexts during init,
 list them later
Date: Sun, 11 Aug 2019 10:27:30 -0500
Message-ID: <486556da-b3c7-8c6a-e7a8-58097dd449be@gmail.com>
In-Reply-To: <1ddfad22-c661-0faf-11e3-d4f107fdfc37@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8480390280411676989==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

>> +=C2=A0=C2=A0=C2=A0 void (*get_active_auto_context)(struct ofono_gprs *g=
prs,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ofono_gprs_active_context_cb_=
t cb,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *data);
> =

> list_active_contexts?=C2=A0 Also, since there can in theory be multiple o=
nes =

> of these, I'd do something like:
> =

> typedef void (*ofono_gprs_active_context_cb_t)(int cid, const char *apn,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *da=
ta);
> =

> void (*list_active_contexts)(struct ofono_gprs *gprs,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ofono=
_gprs_active_context_cb_t active_cb,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ofono=
_gprs_cb_t finished_cb);
> =


As an alternative to the above you can simply do:

void (*list_active_contexts)(struct ofono_gprs *gprs,
				ofono_gprs_cb_t cb);

And direct the driver to issue N ofono_gprs_context_activated calls =

followed by cb.  Where N is the number of active contexts.

Regards,
-Denis

--===============8480390280411676989==--

