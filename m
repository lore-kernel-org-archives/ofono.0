Content-Type: multipart/mixed; boundary="===============5556202647001750351=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [mmsd] Error handling while receiving message
Date: Fri, 23 Mar 2012 10:40:54 +0100
Message-ID: <4F6C4526.20502@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5556202647001750351==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I'm working on handling errors while receiving an MMS (listed in TODO as =

: "Error cases should handled and reported to the application layer." in =

MMS Reception section).

What kind of error do you want to report to the application : generic =

MMS reception error such as "Unable to decode message", "Unable to =

download message" ... or more accurate error (error code, "HTTP error =

XXX", "Communication error while downloading message"... ) ?

Since the reception is automatically performed, there is no D-Bus reply =

msg to use to send error back to the application !
I cannot always handle the error in 'Message' interface since the D-Bus =

object (associated to the message) does not exist before having =

downloaded the entire message. More generally, how to handle errors that =

occurs before the message D-Bus object has been published ?
Should I define a new signal ("MessageError") in 'Service' interface to =

report errors ?

What kind of information the reported error should contain ? the sender =

(if the notification has been decoded), the meta file path (if =

available) ... ?

Thanks in advance,
Regards,

Ronald

--===============5556202647001750351==--

