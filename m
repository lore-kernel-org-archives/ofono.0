Content-Type: multipart/mixed; boundary="===============6979707095065613414=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: CDMA voicecall driver
Date: Fri, 21 Jun 2013 10:58:53 -0500
Message-ID: <51C4783D.4030704@gmail.com>
In-Reply-To: <CAHtt_w=VW5tDZrcsSo8ceq_zsGLteLwQphdcV_k1ESUfNztDwg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6979707095065613414==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 06/19/2013 07:24 PM, TengChou Yang wrote:
> Hi all,
> I am currently working on Sierra modem (MC5728V). Looks like CDMA is not
> fully supported for the voicecall yet.
> What I see from ofono master branch there are only probe, remove, dial,
> hangup had been implemented. I am working
> on other's method step by step. I am wondering is it worth it to change
> the dbus service path from org.ofono.cdma.voicecallmanager

Err, that is not a dbus service path.  The service path is always the =

same, org.ofono.  What you're referring to is the dbus interface name.

> to org.ofono.voicecallmanager? In this case, application doesn't need to
> care about it's GSM modem or CDMA modem,
> what they need to do is connecting to the same dbus path.

No, the API has been specifically designed to separate CDMA and GSM =

details.  There are too many differences in the two systems and their =

respective capabilities to mash them together.

Regards,
-Denis


--===============6979707095065613414==--

