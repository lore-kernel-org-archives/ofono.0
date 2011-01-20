Content-Type: multipart/mixed; boundary="===============0876505411387742780=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/4] atmodem: sim-auth atom driver.
Date: Thu, 20 Jan 2011 11:30:02 -0600
Message-ID: <4D38711A.6040608@gmail.com>
In-Reply-To: <B668883EB5DD7144ADFC248A72176EA802DA0746@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0876505411387742780==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

>> +	buffer =3D g_malloc(len);
> =

> missing check for buffer memory allocation failure =

> =


Actually he's using g_malloc, so the application will simply abort.

>> +	sad =3D g_new0(struct sim_auth_data, 1);
> =

> missing check for "sad" memory allocation failure =


Same here.

My view is that checking mallocs of small structures is pretty much
pointless on Linux.

Regards,
-Denis

--===============0876505411387742780==--

