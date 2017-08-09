Content-Type: multipart/mixed; boundary="===============7671296283719163831=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: AW: AW: connmand[186]: Online check failed but running dhclient
 manually fixes this issue
Date: Wed, 09 Aug 2017 17:36:45 +0200
Message-ID: <03c78aa2-1016-e200-b933-ef25627b5f27@monom.org>
In-Reply-To: <c01ba3df-7c71-3d6b-d1ba-598592614f75@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7671296283719163831==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe and Eswaran,

I just discussed this problem with Denis on IRC. Denis is quite sure the =

modem is broken. To fix this, we need to add a quirk to the device =

driver in oFono code base which disables the IP configuration reporting. =

With this ConnMan will use DHCP in those cases.

Could you send me the exact modem description you are using? So that we =

can write quirk?

Thanks,
Daniel

--===============7671296283719163831==--

