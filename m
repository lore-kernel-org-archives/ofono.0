Content-Type: multipart/mixed; boundary="===============7264369975773747330=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Return SIM file access conditions from read_file_info.
Date: Mon, 27 Jul 2009 18:13:09 -0500
Message-ID: <200907271813.10545.denkenz@gmail.com>
In-Reply-To: <1248106299-5861-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7264369975773747330==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I've pushed this patch with some modifications afterward.  From reading the =

spec myself, I noticed that our interpretations are a 'bit' different.

According to TS 11.11 9.3:
- Read is in byte 9, upper 4 bits
- Update is in byte 9, lower 4 bits
- Increate is in byte 10, upper 4 bits
- Rehabilitate is in byte 11, upper 4 bits
- Invalidate is in byte 11, lower 4 bits

I've reworked the code according to the above spec.

Yet in your implementation they were in bytes 10-12 with lower & upper =

swapped.  E.g. Read in byte 10, lower 4 bits.

Can you confirm that my interpretation is correct, or am I missing somethin=
g?

Regards,
-Denis

--===============7264369975773747330==--

