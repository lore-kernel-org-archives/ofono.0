Content-Type: multipart/mixed; boundary="===============0379615508782422062=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH QMI LTE v2 07/13] qmi: read_settings needs to call start
 network
Date: Fri, 14 Apr 2017 17:57:10 -0500
Message-ID: <8f8058a9-8e63-c7b8-7141-25a413268699@gmail.com>
In-Reply-To: <20170414213646.32066-8-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0379615508782422062==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 04/14/2017 04:36 PM, Jonas Bonn wrote:
> For LTE networks, a default bearer is automatically activated when
> the modem registers to the network.  QMI modems, however, do not
> automatically enable the network interface just because the bearer
> exists; a call to "start network" needs to be made in order to
> get the packet handle before get_settings will return any data and
> the network interface can be configured.
>
> This patch makes read_settings call "start network" in order to
> enable the interface for the default bearer.  No new bearer will
> be created with this call and the settings for the bearer will come
> from the default profile, irregardless of what parameters are passed
> to the "start network" method.
> ---
>  drivers/qmimodem/gprs-context.c | 58 ++++++++++++++++++++++-------------=
------
>  1 file changed, 31 insertions(+), 27 deletions(-)
>

Applied, thanks.

Regards,
-Denis


--===============0379615508782422062==--

