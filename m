Content-Type: multipart/mixed; boundary="===============6405606543121652152=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/5] cdma-sms: Add CDMA SMS Support
Date: Mon, 20 Dec 2010 14:36:15 -0600
Message-ID: <4D0FBE3F.7050109@gmail.com>
In-Reply-To: <1291854951-2378-3-git-send-email-lei.2.yu@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6405606543121652152==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 12/08/2010 06:35 PM, Lei Yu wrote:
> ---
>  Makefile.am        |    3 +-
>  src/cdma-sms.c     |  342 ++++++++++++++++++++++++++++++++++++++
>  src/cdma-smsutil.c |  467 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  src/cdma-smsutil.h |  264 +++++++++++++++++++++++++++++

Please break this up into two patches, one for atom implementation
(along with ofono.h change from Patch 1) and the utilities in a separate
patch.  Otherwise it becomes a wee bit too big to handle ;)

Regards,
-Denis

--===============6405606543121652152==--

