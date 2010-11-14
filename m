Content-Type: multipart/mixed; boundary="===============6681078747186773616=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [PATCH v5b 2/3] stemodem: Create network interfaces statically
Date: Sun, 14 Nov 2010 19:48:38 +0100
Message-ID: <AANLkTinsa3jUV7J559gS5bp5Nua24jbL-xKM7p3aATOc@mail.gmail.com>
In-Reply-To: <1289611942.3266.124.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6681078747186773616==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel.

>> - =C2=A0 =C2=A0 struct conn_info *conn;
>> + =C2=A0 =C2=A0 struct conn_info *conn =3D NULL;
>> =C2=A0 =C2=A0 =C2=A0 GSList *l;
>
> why do you need the conn =3D NULL assignment here? I haven't even looked
> into your code flow, but I prefer clearly to not have these.

I have removed this and tried to remove some of the other
initialisations at declaration as well.
New patch set on the remaining gprs-context changes is on it's way :-)

Regards,
Sjur

--===============6681078747186773616==--

