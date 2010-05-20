Content-Type: multipart/mixed; boundary="===============2536727717366826414=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: commit "Fix Use hashtable to record udev path" breaks huawei
Date: Thu, 20 May 2010 08:13:55 +0300
Message-ID: <87aarv6tpo.fsf@potku.valot.fi>
In-Reply-To: <33AB447FBD802F4E932063B962385B351E8DD24D@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2536727717366826414==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

"Zhang, Zhenhua" <zhenhua.zhang@intel.com> writes:

> Hi Kalle,

Hi Zhenhua,

> Kalle Valo wrote:
>> Kalle Valo <kalle.valo@canonical.com> writes:
>> =

>>> while working on third version of my huawei gprs patches I noticed
>>> that this commit breaks huawei:
>>> =

>>> commit af976f7e524746b1b55645967e11ab8250f593a8
>>> Author: Zhenhua Zhang <zhenhua.zhang@intel.com>
>>> Date:   Tue May 11 09:04:28 2010 +0800

[...]

>> Sorry, I was too hasty. The patch is fine, I was just testing
>> inproperly. After a bit more testing I found out that problem
>> always happens when I plugin the usb modem:
>> =


[...]

> My commit af976f7e524 should not impact modem detection and power up
> stage. If you found huawei modem still exists in oFono after you
> unplug the dungle, I guess something maybe wrong in my patch. :-)

Your patch is fine, I was just testing inproperly. I didn't use the
exactly the same test steps when I did the revert/unrevert cycle of your
patch, and that's why I falsely assumed that your patch broke it. Sorry
about that.

-- =

Kalle Valo

--===============2536727717366826414==--

