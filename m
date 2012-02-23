Content-Type: multipart/mixed; boundary="===============8935963948451462901=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: Re: [PATCHv2 6/8] call-forwarding: Don't run conditional queries if
 cfu is active
Date: Thu, 23 Feb 2012 11:51:35 +0200
Message-ID: <4F460C27.8040102@intel.com>
In-Reply-To: <4F44EC8E.90501@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8935963948451462901==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

On 02/22/2012 03:24 PM, Denis Kenzior wrote:
> The rest is on the right track, however I don't think this really works
> in the case where CFU is set when the query is being performed for the
> first time.
>
> e.g.
> - GetProperties ->  query all
> - CFU is set, so don't query conditionals (which is correct since they
> are useless)
> - CFU is removed ->  conditionals need to be updated now since they don't
> reflect reality

Thanks for the review and for pointing this out. I will check how this coul=
d be =

corrected.

Regards,
Oleg
-- =

Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki
Business Identity Code: 0357606 - 4
Domiciled in Helsinki


--===============8935963948451462901==--

