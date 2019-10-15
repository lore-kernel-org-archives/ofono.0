Content-Type: multipart/mixed; boundary="===============3247030634739344922=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] xmm7modem: fix for crash after receiving MT SMS after SIM
 swap
Date: Tue, 15 Oct 2019 10:45:05 -0500
Message-ID: <78b510a5-8f83-9b1e-be7b-f8ccfaeccf3e@gmail.com>
In-Reply-To: <1571115055-13615-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3247030634739344922==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

On 10/14/19 11:50 PM, Antara Borwankar wrote:
> Earlier SMS atom was being created based on +XSIMSTATE command,
> which is a proprietary command for intel modems.
> But this logic fails in case of SIM hot swap when +XSIMSTATE
> value received is not handled in notify function.

Which value isn't handled?  Should the plugin be handling it instead?

> There can be other such scenarios as well. Therefore SMS atom
> will now be created in post_online function which anyways gets
> called after +XSIMSTATE SMS READY and PB READY is received.

Are you sure? Looking at the code it invokes ofono_sim_initialized even =

after just SIM inserted / PIN not needed.  And it is entirely possible =

for the modem to be Online for emergency calls, in which case SIM =

insertion or PIN entry will get one to post_online potentially skipping =

any SMS/phonebook ready notifications.

> ---
>   plugins/xmm7xxx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =


Regards,
-Denis
--===============3247030634739344922==--

