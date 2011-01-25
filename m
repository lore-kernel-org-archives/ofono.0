Content-Type: multipart/mixed; boundary="===============4711350970248364209=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: Re: [PATCH] Don't use c++ keyword in public header files
Date: Tue, 25 Jan 2011 12:42:56 -0200
Message-ID: <AANLkTi=sGNer4hcBGvMLSdYpMsj_y98cK517N2r+S9Dz@mail.gmail.com>
In-Reply-To: <1295956464.1520.24.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4711350970248364209==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel

On Tue, Jan 25, 2011 at 9:54 AM, Marcel Holtmann <marcel@holtmann.org> wr=
ote:
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
const char *old, const char *new,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
const char *p_old, const char *p_new,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ofono_sim_lock_unlock_cb_t cb, void *data);
>> =C2=A0 =C2=A0 =C2=A0 void (*lock)(struct ofono_sim *sim, enum ofono_sim_=
password_type type,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 int enable, const char *passwd,
>
> why is this exactly a problem?

I did it only because the file contains this:

#ifdef __cplusplus
extern "C" {
#endif


So I thought someone might want to write a plugin in C++ or something
that includes sim.h

> And if you really wanna do that, then please not something cryptic like

No, I don't want. If nobody will use C++, I'm fine the way it is. Then
we might want to remove that ifdef, because it will not compile
anyway.



regards,

Lucas De Marchi

--===============4711350970248364209==--

