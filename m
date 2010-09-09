Content-Type: multipart/mixed; boundary="===============1753572159746462598=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Check if ussd is busy when doing ss
Date: Thu, 09 Sep 2010 09:07:29 -0500
Message-ID: <4C88EA21.3020302@gmail.com>
In-Reply-To: <1283739595-11903-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1753572159746462598==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

On 09/05/2010 09:19 PM, Yang Gu wrote:
> It's still not clear how ss and ussd interfere with each other. Current
> decision is each ss (call-barring, call-forwarding, etc.) has
> interference with ussd, but there is no interference within these ss.
> That is, call-barring has interference with ussd, but call-barring has
> no interference with call-forwarding.

Patch has been applied, but I broke it up into four patches.

Are you planning to take care of cb_ss_control, cb_ss_password,
cf_ss_control and cs_ss_control busy conditions separately?

Regards,
-Denis

--===============1753572159746462598==--

