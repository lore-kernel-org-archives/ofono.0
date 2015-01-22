Content-Type: multipart/mixed; boundary="===============5412765588969094190=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: Re: [PATCH] gprs: Setup route for mmsc if there's no mms proxy
Date: Thu, 22 Jan 2015 23:53:18 +0200
Message-ID: <54C1714E.6070403@jolla.com>
In-Reply-To: <1420546359-7977-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5412765588969094190==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


> And don't setup mms route at all if mmsc/proxy host name is not in
> dotted IPv4 format.
> ---
>   src/gprs.c | 25 ++++++++++++++++++++-----
>   1 file changed, 20 insertions(+), 5 deletions(-)

Sorry, somehow I missed the reply to this patch and just accidentally =

found it (the reply) at mail-archive.com.

This patch has to do the the case when no MessageProxy is provided for =

the MMS context. In that case ofono would set up host route for =

255.255.255.255 (INADDR_NONE returned by inet_addr for the empty string) =

for the MMS interface when it comes up.

With these changes the whole thing has a chance to work if MessageCenter =

URL contains IP address in the host part. In any case, configuring host =

route for 255.255.255.255 doesn't make any sense.

Regards,
-Slava

--===============5412765588969094190==--

