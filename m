Content-Type: multipart/mixed; boundary="===============5886936140638966779=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: Re: [PATCH 4/4] Fix server only return the final parser result
Date: Thu, 04 Mar 2010 09:31:30 +0800
Message-ID: <4B8F0D72.9050609@intel.com>
In-Reply-To: <201003031309.44884.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5886936140638966779==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 03/04/2010 03:09 AM, Denis Kenzior wrote:
> Hi Zhenhua,
>
>> In case we meet compound commands in single line, AtServer should
>> only return the parser result of last command according to spec.
>> So we return the parser result in the parse iteration.
>
> So I agree that we need to do this, but I disagree with the approach.  I
> suggest we let g_at_server_send_result take care of this.  This will make
> extended errors much easier to handle.

OK. I will try your approach and send out code later.

> Regards,
> -Denis
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>


--===============5886936140638966779==--

