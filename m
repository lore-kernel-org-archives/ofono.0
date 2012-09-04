Content-Type: multipart/mixed; boundary="===============3010795060798329522=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 12/12] doc: Add ReportChanged signal description
Date: Tue, 04 Sep 2012 14:20:00 -0500
Message-ID: <50465460.7080706@gmail.com>
In-Reply-To: <50461DAA.2090602@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3010795060798329522==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ronald,

>>> + ReportChanged(string type, variant recipient, variant status)
>>> +
>>> + Signal that is sent when a report has been received and
>>> + processed. It contains the type of the report
>>> + ("delivery_report" or other), the recipient concerned
>>> + and its new status.
>>> +
>>
>> Why are we not simply changing the 'Status' to delivered/expired, etc?
>
> Unfortunately, we cannot use the message status because there is one
> delivery status per recipient (a message can be sent to 2 (or more)
> recipients, so it can be delivered to one of them and "not yet
> delivered" to the other one).
>

So how do you expect this to work? Is the application responsible for =

aggregating the recipients?  If so, then that is not a good idea, mmsd =

should be doing as much work as possible here.

Can't we use delivered/partially_delivered/expired and provide exact =

status details as a dictionary?

Regards,
-Denis

--===============3010795060798329522==--

