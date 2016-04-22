Content-Type: multipart/mixed; boundary="===============5277720763255915669=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 00/24] [RFC] Don't rely on undefined behavior when casting
 function pointers
Date: Fri, 22 Apr 2016 15:42:52 -0500
Message-ID: <571A8CCC.1050304@gmail.com>
In-Reply-To: <1461330601-21333-1-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5277720763255915669==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi John,

On 04/22/2016 08:10 AM, John Ernberg wrote:
> From: John Ernberg <john.ernberg@actia.se>
>
> Casting between incompatible function pointer types is undefined.
> While it works fine on x86, it's not a good idea to depend on this.
>
> This RFC uses g_slist_free_full where possible, and when it's not works a=
round
> the casting using other means such as wrappers or fixing function paramet=
ers.
>

I applied all of these except patch 20.  See my comments in the relevant =

reply.

Thanks for doing all the work.

Regards,
-Denis


--===============5277720763255915669==--

