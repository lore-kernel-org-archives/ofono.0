Content-Type: multipart/mixed; boundary="===============6982317546702658820=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: [PATCH 2/3] atmodem: add a huawei hack to check attachment status
Date: Fri, 23 Apr 2010 18:43:49 +0300
Message-ID: <87ljcerx6y.fsf@potku.valot.fi>
In-Reply-To: <1272032654.22838.71.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6982317546702658820==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Marcel Holtmann <marcel@holtmann.org> writes:

> Hi Kalle,

Hi Marcel,

>> Huawei doesn't seem to send CGREG notifications (or I wasn't able to
>> properly configure the modem to do it), so add an ugly to hack poll the
>> state with CGATT.
>
> shouldn't be polling AT+CGREG? the better way to do this?

Most probably, I'll try with that command and test how it goes.

But is polling acceptable way to do this? And is there anything else I
could do except poll? I'm open to all suggestions.

-- =

Kalle Valo

--===============6982317546702658820==--

