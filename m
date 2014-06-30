Content-Type: multipart/mixed; boundary="===============1636096376203531548=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] hfpmodem: Fix crash with more than two calls
Date: Mon, 30 Jun 2014 13:46:03 -0500
Message-ID: <53B1B06B.4060506@gmail.com>
In-Reply-To: <1403855767-10561-1-git-send-email-sergio.checa@oss.bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1636096376203531548==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sergio,

On 06/27/2014 02:56 AM, Sergio Checa Blanco wrote:
> From: Sergio Checa Blanco <sergio.checa@bmw-carit.de>
> =

> A periodic CLCC polling is started when there is an ongoing multiparty
> call and a new call appears in the system. A simple way to reproduce
> the crashing scenario is:
> =

> 1. Place a call.
> 2. Place a second call.
> 3. Create a multiparty call with both calls.
> 4. Place a third call (incoming or outgoing does not matter).
> 5. Disconnect HFP from the modem.
> =

> Within the function ciev_callheld_notify, the AT+CLCC command is also
> invoked, thus a new cyclic CLCC polling is started, and it overwrites
> the timer resource identifier stored in voicecall_data.clcc_source.
> This means that there are several timers doing the CLCC polling, but
> only one of those is under control, i.e. it can be removed through its
> source identifier, hence a timer source leak.
> =

> This has a fatal consequence when the HFP modem is disconnected. The
> function hfp_voicecall_remove stops the timer that is under control
> before freeing the voicecall_data struct. However there are other timers
> that are still active and will execute its handler poll_clcc afterwards.
> Inside poll_clcc the driver_data is accessed, which is already NULL.
> =

> A solution for this is to avoid starting a CLCC polling if there is
> already one active, i.e. clcc_source is not 0. By doing this the
> uncontrolled timers will not cycle forever.
> ---
>  drivers/hfpmodem/voicecall.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============1636096376203531548==--

