Content-Type: multipart/mixed; boundary="===============6126934310530363283=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] stkagent: Free pending call when destroying agent.
Date: Wed, 18 Aug 2010 00:34:04 -0500
Message-ID: <4C6B70CC.90309@gmail.com>
In-Reply-To: <1282059423-28864-2-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6126934310530363283==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 08/17/2010 10:37 AM, Andrzej Zaborowski wrote:
> Otherwise we leak memory and additionally D-bus invokes the method
> callback and since the agent is already destroyed, we segfault.
> ---

Good catch.  Patch has been applied, thanks.

Regards,
-Denis

--===============6126934310530363283==--

