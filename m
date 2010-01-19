Content-Type: multipart/mixed; boundary="===============8142383373115674541=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC v2 6/7] STE-plugin: Add CAIF header files in gcaif.
Date: Tue, 19 Jan 2010 11:52:47 -0800
Message-ID: <1263930767.5591.195.camel@localhost.localdomain>
In-Reply-To: <1263917513-6756-7-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8142383373115674541==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> Adding CAIF header files. These should be removed when
> CAIF is included Linux kernel.

please put them into drivers/stemodem/ instead as I explained in the
other email. And make sure they are before its actual usage in the patch
series.

Regards

Marcel



--===============8142383373115674541==--

