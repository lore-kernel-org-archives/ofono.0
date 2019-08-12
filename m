Content-Type: multipart/mixed; boundary="===============0732295778764946448=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] gprs: Ignore activated contexts during init,
 list them later
Date: Mon, 12 Aug 2019 14:58:31 -0500
Message-ID: <68c118a8-0d33-4a20-186c-dd553280d00c@gmail.com>
In-Reply-To: <CAHB-Pjnq8mGvJKYZY_j-0eQtbtd3VDfo_YuLk0PhYB-P8B-HOw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0732295778764946448==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

>     list_active_contexts?=C2=A0 Also, since there can in theory be multip=
le ones
>     of these, I'd do something like:
> =

>     typedef void (*ofono_gprs_active_context_cb_t)(int cid, const char *a=
pn,
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 void *data);
> =

>     void (*list_active_contexts)(struct ofono_gprs *gprs,
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ofono_gprs_active_context_cb_t active_cb,
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ofono_gprs_cb_t finished_cb);
> =

> Nice solution, I assume we call the callback multiple times.
> And if none is found we still call it once with -1 and null, right?

Well, that is what the finished_cb is for.  But I guess you liked the =

other solution better.  They're equivalent in the end.

Regards,
-Denis

--===============0732295778764946448==--

