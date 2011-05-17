Content-Type: multipart/mixed; boundary="===============2056630827622568211=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Adding New contact failed in Ofono
Date: Mon, 16 May 2011 23:33:12 -0700
Message-ID: <1305613992.15916.184.camel@aeonflux>
In-Reply-To: <BANLkTi=4FuTTL1=Jw=+C2KSy+O07xCkh8w@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2056630827622568211==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yuvi,

please respect the mailing etiquette and do not top post.

> Suppose end user wants to store his/her contact number in SIM. What is the
> way to do?
> =

> Actually all mobile devices supporting these features. ( Personally i feel
> that very end user expecting these feature).

This is actually not true. Neither the iPhone nor Android devices are
supporting writing to the SIM card. They only support importing contacts
from the SIM card for legacy reasons. And oFono does support exactly the
same.

The Android Nexus S export functionality for example is only USB and
sharing your contacts over Bluetooth or via email. No exporting to SIM
card is supported.

> I don't know ,there could some technical reasons

The SIM phonebook is too limited in the number of field or number of
entries to be anywhere near useful for anybody. It is not a storage
location that should be used anymore. It is ancient and outdated.

And for the same reason we do not support storing SMS on the SIM card
and import existing ones if found.

Regards

Marcel



--===============2056630827622568211==--

