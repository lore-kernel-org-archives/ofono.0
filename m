Content-Type: multipart/mixed; boundary="===============6874831489328029058=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] src/gprs: support for NONE auth
Date: Thu, 27 Sep 2018 11:28:35 -0500
Message-ID: <f1f91ac7-4887-e9d2-b8cc-54085f5a71ee@gmail.com>
In-Reply-To: <20180925132035.19417-2-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6874831489328029058==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

On 09/25/2018 08:20 AM, Giacinto Cifelli wrote:
> ---
>   src/gprs.c | 7 +++++++
>   1 file changed, 7 insertions(+)

I don't believe this patch is complete.  It doesn't address certain =

issues that arise from the introduction of this auth method.  For =

example, what happens if a context with:
AuthenticationMethod=3DChap
Username=3Dfoo
Password=3Dbar

gets AuthenticationMethod property set to 'None'?  Do Username & =

Password remain untouched?  Are they changed to empty automatically?

What happens now to the drivers if such a context is activated?  Some of =

them can handle this because they only look at the presence of =

Username/Password.  But others will try to set authentication method to =

None yet still append username / password...

What happens if
AuthenticationMethod=3DNone and the client tries to set
Username to 'foo'?  Is that an error? Success?

All of these issues need to be explained in your patch description...

Regards,
-Denis

--===============6874831489328029058==--

