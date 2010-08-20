Content-Type: multipart/mixed; boundary="===============7715503099707067181=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] stk: reorder: Don't access freed memory in Send SMS
Date: Fri, 20 Aug 2010 09:04:10 -0500
Message-ID: <4C6E8B5A.8070804@gmail.com>
In-Reply-To: <1282270029-2909-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7715503099707067181==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 08/19/2010 09:07 PM, Andrzej Zaborowski wrote:
> Responding to the stk->pending_cmd frees it, we need to read it
> before that.
> ---

Patch has been applied, thanks.

Regards,
-Denis

--===============7715503099707067181==--

