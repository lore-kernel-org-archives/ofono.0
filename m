Content-Type: multipart/mixed; boundary="===============3274889614262782314=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH v2 06/19] hfpmodem: Support for +BSIR unsol. result codes
Date: Fri, 14 Oct 2011 10:51:31 +0200
Message-ID: <4E97F813.4030500@bmw-carit.de>
In-Reply-To: <4E972A89.3090206@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3274889614262782314==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,
> Why exactly are you using parse_reg_unsolicited here?  That one is meant
> to parse +CREG/+CGREG unsolicited responses, probably not the right
> thing for BSIR, just using g_at_result_iter_next_number would be enough
> here.
>

You're right, it doesn't make any sense, and the same issue is included =

in patch 14/19. Sorry for that.

Also, I understand now why you suggested leaving the vendor information =

out in the first review.

Let me send updated patches next week.

Regards,
Mikel


--===============3274889614262782314==--

