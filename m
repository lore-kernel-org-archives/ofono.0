Content-Type: multipart/mixed; boundary="===============8019749728235280102=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/8] gps: define new dbus interface
Date: Wed, 22 Dec 2010 15:45:16 -0600
Message-ID: <4D12716C.8010709@gmail.com>
In-Reply-To: <1292531423-22316-2-git-send-email-rafael.zurita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8019749728235280102==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

On 12/16/2010 02:30 PM, Rafael Ignacio Zurita wrote:
> ---
>  include/dbus.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> =

> diff --git a/include/dbus.h b/include/dbus.h
> index 9e29afb..48e8ac4 100644
> --- a/include/dbus.h
> +++ b/include/dbus.h
> @@ -54,6 +54,7 @@ extern "C" {
>  #define OFONO_VOICECALL_MANAGER_INTERFACE "org.ofono.VoiceCallManager"
>  #define OFONO_STK_INTERFACE OFONO_SERVICE ".SimToolkit"
>  #define OFONO_SIM_APP_INTERFACE OFONO_SERVICE ".SimToolkitAgent"
> +#define OFONO_GPS_INTERFACE OFONO_SERVICE ".Gps"

Please name this 'LocationReporting'

Regards,
-Denis

--===============8019749728235280102==--

