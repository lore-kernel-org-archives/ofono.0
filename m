Content-Type: multipart/mixed; boundary="===============8743357625595497612=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH 4/4] qmimodem: get LTE default bearer APN from modem
Date: Fri, 02 Mar 2018 16:14:24 +0100
Message-ID: <030be422-aac3-8302-c15d-c62d3d5a963e@southpole.se>
In-Reply-To: <20180301223015.7bkg2wkzts4e3g7u@arcor.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8743357625595497612==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 03/01/2018 11:30 PM, Reinhard Speyerer wrote:
> =

> Hi Jonas,
> =

> if you only need to know the APN and the IP version assigned by the netwo=
rk
> for the default bearer you could try to use WDSGetLTEAttachParameters
> (WDS msgid 0x0085) instead of using WDSStartNetworkInterface followed by
> WDSGetCurrentSettings.

Thanks, Reinhard!

That information was invaluable.  I've been looking for that for ages!

I've reworked my patches using your suggestion and things work _much_ =

better.

/Jonas

> =

> Regards,
> Reinhard
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono
> =



--===============8743357625595497612==--

