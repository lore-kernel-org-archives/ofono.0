Content-Type: multipart/mixed; boundary="===============4047275160851174032=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH v3 00/13] Add support for BlueZ 5 Profile1 API to dundee
Date: Sun, 24 Mar 2013 13:31:51 +0100
Message-ID: <514EF237.3050801@monom.org>
In-Reply-To: <1363818402-17710-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4047275160851174032==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paulo,

I have pushed all patches except patch #3. "dun_gw: Add BlueZ 5 version" =

from Fr=C3=A9d=C3=A9ric just added recently the definition for DUN_GW_UUID. =

Obviously, I needed to update your patches to use DUN_GW_UUID instead of =

DUN_UUID. The bluez4.c file also uses DUN_GW_UUID as identifier.

Thanks a lot,
daniel

--===============4047275160851174032==--

