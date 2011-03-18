Content-Type: multipart/mixed; boundary="===============7571277503584707704=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 01/12] dbus: add gnss interface definition
Date: Thu, 17 Mar 2011 23:26:19 -0500
Message-ID: <4D82DEEB.4010203@gmail.com>
In-Reply-To: <1299846189-15132-2-git-send-email-jarko.poutiainen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7571277503584707704==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jarko,

On 03/11/2011 06:22 AM, Jarko Poutiainen wrote:
> ---
>  include/dbus.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> =

> diff --git a/include/dbus.h b/include/dbus.h
> index 19a138a..bf3e8a4 100644
> --- a/include/dbus.h
> +++ b/include/dbus.h
> @@ -56,6 +56,8 @@ extern "C" {
>  #define OFONO_STK_INTERFACE OFONO_SERVICE ".SimToolkit"
>  #define OFONO_SIM_APP_INTERFACE OFONO_SERVICE ".SimToolkitAgent"
>  #define OFONO_LOCATION_REPORTING_INTERFACE OFONO_SERVICE ".LocationRepor=
ting"
> +#define OFONO_AS_NAVIGATION_INTERFACE "org.ofono.AssistedSatelliteNaviga=
tion"

Please name this OFONO_GNSS_INTERFACE

> +#define OFONO_POSITIONING_REQUEST_INTERFACE "org.ofono.PositioningReques=
tAgent"

Please name this OFONO_GNSS_POSR_INTERFACE or
OFONO_GNSS_POSR_AGENT_INTERFACE

Or feel free to suggest a better name, but the current names are getting
too big

>  =

>  /* CDMA Interfaces */
>  #define OFONO_CDMA_VOICECALL_MANAGER_INTERFACE "org.ofono.cdma.VoiceCall=
Manager"

Regards,
-Denis

--===============7571277503584707704==--

