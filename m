Content-Type: multipart/mixed; boundary="===============5082108881378793274=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 13/13] [RfC] API for STK driver to signal executed
 commands.
Date: Thu, 14 Oct 2010 04:17:49 -0500
Message-ID: <4CB6CABD.8070605@gmail.com>
In-Reply-To: <1286978056-16600-13-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5082108881378793274==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 10/13/2010 08:54 AM, Andrzej Zaborowski wrote:
> Some modems are able to handle some proactive commands in their
> firmware or otherwise, if the command doesn't require input from user.
> Nevertheles ofono may need to update internal state or notify the user
> where necessary.  With this api the driver can notify core that a
> command is being executed in the modem or that a command is finished
> executing and the TERMINAL RESPONSE has been sent to SIM.  It would
> also be possible for a driver to handle a command.

I applied this patch with a small tweak to make it compile.

Thanks,
-Denis

--===============5082108881378793274==--

