Content-Type: multipart/mixed; boundary="===============2903244977113403552=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/5] qmi: provide AvailableTechnologies in radio-settings
Date: Thu, 07 Sep 2017 11:59:30 -0500
Message-ID: <f1edd04b-c4a9-2c6f-7842-d5735e4532ab@gmail.com>
In-Reply-To: <20170907121136.13520-3-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2903244977113403552==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 09/07/2017 07:11 AM, Jonas Bonn wrote:
> This provides the list of available technologies in the radio-settings
> atom.  Note that this list is hard-coded and includes LTE unconditionally
> which is probably not correct for all QMI devices.

I don't like this idea.  There has to be a way to figure out the =

capability, either from udev or QMI protocol.  Does the command =

Christophe mentioned work for this?

> ---
>   drivers/qmimodem/radio-settings.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> =


Regards,
-Denis

--===============2903244977113403552==--

