Content-Type: multipart/mixed; boundary="===============3727799274160734931=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv3 1/7] sim-auth: prep simauth/dbus headers
Date: Wed, 11 Oct 2017 14:17:21 -0500
Message-ID: <0a0f3fb5-02e9-797a-16ab-729fdaabc5e3@gmail.com>
In-Reply-To: <1507748268-4799-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3727799274160734931==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/11/2017 01:57 PM, James Prestwood wrote:
> Added new dbus interfaces for SimAuth module as well as
> function prototype definitions to simauth header.
> =

> org.ofono.SimAuthentication:
>     Interface to hold the auth object to type mapping property
> =

> org.ofono.USimApplication:
>     Application with USim functionality (GSM/UMTS auth)
> =

> org.ofono.ISimApplication:
>     Application with ISim functionality (IMS auth)
> ---
>   include/dbus.h     |  3 +++
>   include/sim-auth.h | 20 +++++++++++++++++++-
>   2 files changed, 22 insertions(+), 1 deletion(-)
> =


Applied, thanks.

Regards,
-Denis


--===============3727799274160734931==--

