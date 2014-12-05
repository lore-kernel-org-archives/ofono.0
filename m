Content-Type: multipart/mixed; boundary="===============7748770979237212256=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Progress of GPRS IPv6
Date: Thu, 04 Dec 2014 23:00:39 -0600
Message-ID: <54813BF7.5050103@gmail.com>
In-Reply-To: <CAJsouXBBF_11wk-kf=MkwdVT-p8LDW7HDZpJ=51XU-Zp3iHBBA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7748770979237212256==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 12/04/2014 05:32 PM, nanxi wrote:
> Hi oFono team,
>
> I noticed that the support of GPRS IPv6 is still in progress. Wonder if
> there is any estimate on the feature complete date of this feature?
>

Nobody is working on this at the moment.

What is actually missing?  The driver just needs to obtain and forward =

IPv6 details accordingly.  E.g. using ofono_gprs_context_set_ipv6_address...

Regards,
-Denis

--===============7748770979237212256==--

