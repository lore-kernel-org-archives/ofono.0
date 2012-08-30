Content-Type: multipart/mixed; boundary="===============1144491916760494982=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] default.xml: accept SMS with SMSC num "123"
Date: Thu, 30 Aug 2012 12:03:54 -0500
Message-ID: <503F9CFA.7040209@gmail.com>
In-Reply-To: <1346336297-13287-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1144491916760494982==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

On 08/30/2012 09:18 AM, Nicolas Bertrand wrote:
> Reply to the SMS pdu with CMGS:0 when SMSC is set to "123".
> This is used by Send SMS in Demo sim app
> ---
>   src/default.xml |    7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/src/default.xml b/src/default.xml
> index 568259b..78fc9ae 100644
> --- a/src/default.xml
> +++ b/src/default.xml
> @@ -2757,6 +2757,13 @@
>   	<response>+CMGS: 0\n\nOK</response>
>   	<switch name=3D"default"/>
>       </chat>
> +
> +<chat>
> +<!-- Accept messages with SMSC set to 123 (STK app) -->
> +<command>038121F3*</command>
> +<response>+CMGS: 0\n\nOK</response>
> +<switch name=3D"default"/>
> +</chat>

Is there a reason we can't modify the existing default rule to accept =

every SMS?

>   </state>
>
>   <chat>

Regards,
-Denis

--===============1144491916760494982==--

