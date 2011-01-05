Content-Type: multipart/mixed; boundary="===============3635469778912046419=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/3] Add null text/alpha identifier and icon check handling
Date: Wed, 05 Jan 2011 10:07:53 -0600
Message-ID: <4D249759.6040602@gmail.com>
In-Reply-To: <1294180923-12241-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3635469778912046419==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 01/04/2011 04:42 PM, Jeevaka Badrappan wrote:
> Hi,
> =

> Following patch adds the missing "text/alpha identifier and icon"
> check handling.
> =

> As per the ETSI 102 223 section 6.8, Text string is only required in
> response to a GetInkey or GetInput proactive command. So, there is no
> need to add any specific handling for null or empty strings cases.
> =

> As per the ETSI TS 102 223 section 6.5.4, "If the terminal receives an
> icon, and either an empty or no alpha identifier/text string is given
> by the UICC, than the terminal shall reject the command with general"
> result "Command data not understood by terminal"."
> =

> Regards,
> Jeevaka
> =


All three have been applied, thanks.

Regards,
-Denis

--===============3635469778912046419==--

