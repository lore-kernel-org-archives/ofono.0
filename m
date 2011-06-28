Content-Type: multipart/mixed; boundary="===============0534959505652307653=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH]doc: update cdma voice call manager api
Date: Tue, 28 Jun 2011 08:44:30 -0500
Message-ID: <4E09DABE.1090009@gmail.com>
In-Reply-To: <1309230760-4139-1-git-send-email-caiwen.zhang@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0534959505652307653==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

On 06/27/2011 10:12 PM, Caiwen Zhang wrote:
> (1) Add "Calls" property to monitor the current present calls.
> (2) Remove original "State" property, add it as a parameter of "Calls" pr=
operty.
>     and add possible value: "held" and "waiting"
> (3) Remove original "CallWaiting" and "CallWaitingNumber" property(Can ge=
t these
>     information from "Calls" property).
> (4) Remove "ToneDuration" property as it is transparent to user, user don=
't need
>     change it.
> =


Actually I like the current API the way it is.  We looked at trying to
re-use the GSM VoicecallManager style API, however the underlying CDMA
signaling is less sophisticated and thus not as capable.  The present
API looks the way it does for a reason ;)

Can we please concentrate on implementing the cdma.ConnectionManager
interface and making it work with some USB sticks (and of course
ConnMan) to start with?

Regards,
-Denis

--===============0534959505652307653==--

