Content-Type: multipart/mixed; boundary="===============0497901999610310275=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH] Return SIM file access conditions from read_file_info.
Date: Tue, 28 Jul 2009 01:24:12 +0200
Message-ID: <fb249edb0907271624x71206a51ya06b4b9bea481dc@mail.gmail.com>
In-Reply-To: <200907271813.10545.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0497901999610310275==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2009/7/28 Denis Kenzior <denkenz@gmail.com>:
> I've pushed this patch with some modifications afterward. =C2=A0From read=
ing the
> spec myself, I noticed that our interpretations are a 'bit' different.
>
> According to TS 11.11 9.3:
> - Read is in byte 9, upper 4 bits
> - Update is in byte 9, lower 4 bits
> - Increate is in byte 10, upper 4 bits
> - Rehabilitate is in byte 11, upper 4 bits
> - Invalidate is in byte 11, lower 4 bits
>
> I've reworked the code according to the above spec.
>
> Yet in your implementation they were in bytes 10-12 with lower & upper
> swapped. =C2=A0E.g. Read in byte 10, lower 4 bits.
>
> Can you confirm that my interpretation is correct, or am I missing someth=
ing?

Yes, this is correct and I was about to send a new patch for it,
tested on a real SIM.  My doc to pdf converter doesn't display the
tables (with bitfields) correctly in GSM specs.

Regards

--===============0497901999610310275==--

