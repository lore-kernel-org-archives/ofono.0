Content-Type: multipart/mixed; boundary="===============1465987888782954251=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/3] hdlc: allow for scanning and escaping
Date: Sat, 17 Apr 2010 15:34:14 -0700
Message-ID: <1271543654.22838.28.camel@localhost.localdomain>
In-Reply-To: <1271528135-12337-2-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1465987888782954251==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> PPP needs to inspect the packet protocol to see if a character
> should be escaped.  Additionally, it needs to be able to compare
> against recv and xmit accm.

can we just set the ACCM values instead of having an extra function
call. I think that calling an extra function for every single byte is a
really bad idea and the compiler can not optimize it at all.

Regards

Marcel



--===============1465987888782954251==--

