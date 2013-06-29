Content-Type: multipart/mixed; boundary="===============3933499549758758504=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH 1/2] dundee: export Bluetooth address in as D-Bus property
Date: Sat, 29 Jun 2013 21:07:01 +0200
Message-ID: <51CF3055.7090909@monom.org>
In-Reply-To: <1372090442-15152-1-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3933499549758758504==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

I guess you need to figure out which dundee device belongs to which =

BlueZ device, right? I wouldn't mind that information in the commit message.

I have no problem with exposing this information. Please also sent a =

patch for the documentation. BTW, for HFP we expose the BT MAC via the =

Modem.Serial. Should we be consistent with oFono's API here?

cheers,
daniel


--===============3933499549758758504==--

