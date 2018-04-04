Content-Type: multipart/mixed; boundary="===============5361621901691534079=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 5/6] qmi: make version_list private
Date: Wed, 04 Apr 2018 10:02:11 -0500
Message-ID: <b8edf915-7064-2c81-6573-3618f9d648a1@gmail.com>
In-Reply-To: <20180403145056.25817-5-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5361621901691534079==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 04/03/2018 09:50 AM, Jonas Bonn wrote:
> ---
>   drivers/qmimodem/qmi.c | 47 +++++++++++++++++++++++++++++++---
>   drivers/qmimodem/qmi.h | 14 ++++-------
>   plugins/gobi.c         | 68 +++++++++++++++++++------------------------=
-------
>   3 files changed, 74 insertions(+), 55 deletions(-)

I split this up into two commits per our patch submission guidelines.

> +bool qmi_device_get_service_version(struct qmi_device* device, uint8_t t=
ype,

And I had to fix a bunch of instances of misplaced '*' ;)

Regards,
-Denis

--===============5361621901691534079==--

