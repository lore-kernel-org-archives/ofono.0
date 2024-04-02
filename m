Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8822815E80A
	for <ofono@lists.linux.dev>; Tue,  2 Apr 2024 21:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712094423; cv=none; b=R0xFB8Aoar5/Hd4H2V4sL65q1owN4Dzr9npqCHBuKL74UPWpCcB2QEThtu2K/yb1ivbicRu38LfFtEW90FjVkwTvK6K9BLW9PuO3LSHjAzn387beOjKGUQaXnFTYfky+hJl+7Dv4HjzyJQGcrX+SKa1gsVnBkxRyykkB/rCDZWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712094423; c=relaxed/simple;
	bh=39saSZv+RIuDH7dCofiyl4NZAphhVV5jU7SI/CQPwAM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X51PCJmiWEGWyEY2YAhcMepehYXe7DyxVeIoRig315AjyOC/HXtXp0qnOQ5dinDsZ9PHKyS/KwrzEvM8tvcbTQhfhM79eKaSSJTGoR1t2UAPRJnHfpio+IgqzsD3L0WxG/1LbqQSnON+yvGB/fPyGCh4rRHMqwdHcVxTW1o749E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtECTiGn; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtECTiGn"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4155819f710so28214665e9.2
        for <ofono@lists.linux.dev>; Tue, 02 Apr 2024 14:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712094419; x=1712699219; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FXUjtP0SmgRuXxGV6j7pq/vlX9AEXqU+WDhwrnafX9g=;
        b=RtECTiGn93vORSZz/ZvuUA28MIbKphhoD5njJGbDeOGR+GSIE/ymhQ+45OSL6Z1tDg
         sWxmVZSz3QI30tEbyfDKQ32nya1UWgBoXYTiG7UU97WD6XFgadMUiy7D/Ycx/Q7LNXEu
         mExigtMK5bOhvz/OjrpBQzF0i3Q7EQSBr9GF9xuV2mjUUxecMq5/b2wY3Eae+hdfk+RJ
         wW08XdpMyLZ3jVV5jakzON7g86cPHI5BrnvJ9lXrZUGBL3vssxdG/24hhMIA+23D2nWe
         J7UDTbtuN/Lgg0XQ5hoKM3S7EFeiTMl4KbyOhwZI4kjfu0IASi9AvlhphLn5qkUybOAj
         QdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712094419; x=1712699219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXUjtP0SmgRuXxGV6j7pq/vlX9AEXqU+WDhwrnafX9g=;
        b=qH93IZtTbZA3EpTLdnPT7NUT7dgV+ahfU83VgFROHb106saGIMyO84Y861GTtuCo1z
         Ghm66+HWhegf6QDBMg4ZMYLIA6sbpYSdGVpdfxf2vcN/Z9RvrAo69O+G5opklru707kJ
         EG8pI0CTY1n0THIvCLim3XBsEvt9Qf+BNf+Qya9y9TuUCNiVbcJoaQjij/hU8TnqvPde
         NqGe+O7IEsOsHAgLpnqhaktC45jNXf1vZnTD3cAzGHbcqkV7QLSfLQQDTEtPD/szGSz1
         trXDbuRIbqJt6WLLGWryybg6EL4V89cntQRDw1epOTfP/eTw1EAWgIeJipl6lnU+8mCx
         jrKA==
X-Gm-Message-State: AOJu0Yzxs2uizGUJRxDqtXt7fzPZQ+vmEMI1TF5186mCHpOTSBXXM8Gc
	4IvfGapWpfwiofqAd2vAr7VwArKTYi7DAfee5rgTtxDgRKU0FkqPnwfqubYRw6E=
X-Google-Smtp-Source: AGHT+IHeWD2WXYz+eoc4MlWdcgu/BVURq5PtsAwnJqMpZlE/fMscTrn0KcNqr//BMbT4+jQ1aShd4w==
X-Received: by 2002:adf:fc51:0:b0:343:688d:2cbf with SMTP id e17-20020adffc51000000b00343688d2cbfmr2462384wrs.60.1712094419267;
        Tue, 02 Apr 2024 14:46:59 -0700 (PDT)
Received: from adam-laptop-hp.localnet ([90.246.50.91])
        by smtp.gmail.com with ESMTPSA id h18-20020adff192000000b003433a379a51sm1473191wro.101.2024.04.02.14.46.58
        for <ofono@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 14:46:58 -0700 (PDT)
From: Adam Pigg <piggz1@gmail.com>
To: ofono@lists.linux.dev
Subject: Re: [PATCH v3 1/4] qmimodem: voicecall: Implement call dialing
Date: Tue, 02 Apr 2024 22:46:57 +0100
Message-ID: <2253852.vFx2qVVIhK@adam-laptop-hp>
In-Reply-To: <20240402212625.5348-1-adam@piggz.co.uk>
References: <20240402212625.5348-1-adam@piggz.co.uk>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Id just like to add some context about the work ive done for this revision.  I 
didnt figure out how to get git send-email to add a cover note, so this is it 
:)

I -believe- ive implemented all of Dennis' review comments, with the following 
notes:
Patch1
The suggestion to add
_auto_(queue_desroy_free) struct l_queue *calls = l_queue_new() instead.
wasnt nescessary and resulted in a double-free, as the call-list was being 
free'd correctly later on.

Patch4
I moved the cpd params into voicecall as suggested, and added an l_free for 
cbd in the success path which was missing.

I have performed tests of incoming and outgoing call, answering and hanging 
up, doing dtms tones, all while running in valgrind, and did not pick up any 
leaks in this code (there was a leak in the ofono sim code, and one of my 
other patches which I wont upstream)

I have also just noticed that I forgot to do the last comment from Patch 3, so 
feel free to mention that again!

Thanks

Adam

On Tuesday 2 April 2024 22:25:15 BST Adam Pigg wrote:
> Add voicecall dialling to the qmimodem driver
> Includes required infratructure and setup of the QMI services
> 
> Call State Handling
> ===================
> On initialisation, register the all_call_status_ind callback to be
> called for QMI_VOICE_IND_ALL_STATUS.  This will handle notificatiof of
> call status to the rest of the system
> 
> Dial Handling
> =============
> The dial function sets up the parameters for the QMI_VOICE_DIAL_CALL
> service.  The parameters are the number to be called and the call type,
> which is currently hard coded to be QMI_VOICE_CALL_TYPE_VOICE.  The
> dial_cb callback wi then be called and will receive the call-id.
> ---
>  drivers/qmimodem/voice.h     |  17 ++
>  drivers/qmimodem/voicecall.c | 479 ++++++++++++++++++++++++++++++++++-
>  2 files changed, 495 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/qmimodem/voice.h b/drivers/qmimodem/voice.h
> index 917e72f7..2344fd50 100644
> --- a/drivers/qmimodem/voice.h
> +++ b/drivers/qmimodem/voice.h
> @@ -48,6 +48,9 @@ enum qmi_ussd_user_required {
> 
>  /* QMI service voice. Using an enum to prevent doublicated entries */
>  enum voice_commands {
> +	QMI_VOICE_DIAL_CALL =			0x20,
> +	QMI_VOICE_ALL_CALL_STATUS_IND =		0x2e,
> +	QMI_VOICE_GET_ALL_CALL_INFO =		0x2f,
>  	QMI_VOICE_SUPS_NOTIFICATION_IND =	0x32,
>  	QMI_VOICE_SET_SUPS_SERVICE =		0x33,
>  	QMI_VOICE_GET_CALL_WAITING =		0x34,
> @@ -66,6 +69,20 @@ enum voice_commands {
>  	QMI_VOICE_GET_CNAP =			0x4d
>  };
> 
> +enum qmi_voice_call_state {
> +	QMI_VOICE_CALL_STATE_IDLE = 0x0,
> +	QMI_VOICE_CALL_STATE_ORIG,
> +	QMI_VOICE_CALL_STATE_INCOMING,
> +	QMI_VOICE_CALL_STATE_CONV,
> +	QMI_VOICE_CALL_STATE_CC_IN_PROG,
> +	QMI_VOICE_CALL_STATE_ALERTING,
> +	QMI_VOICE_CALL_STATE_HOLD,
> +	QMI_VOICE_CALL_STATE_WAITING,
> +	QMI_VOICE_CALL_STATE_DISCONNECTING,
> +	QMI_VOICE_CALL_STATE_END,
> +	QMI_VOICE_CALL_STATE_SETUP
> +};
> +
>  struct qmi_ussd_data {
>  	uint8_t dcs;
>  	uint8_t length;
> diff --git a/drivers/qmimodem/voicecall.c b/drivers/qmimodem/voicecall.c
> index aa34fc25..cadb5adf 100644
> --- a/drivers/qmimodem/voicecall.c
> +++ b/drivers/qmimodem/voicecall.c
> @@ -3,6 +3,7 @@
>   *  oFono - Open Source Telephony
>   *
>   *  Copyright (C) 2011-2012  Intel Corporation. All rights reserved.
> + *  Copyright (C) 2024 Adam Pigg <adam@piggz.co.uk>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2 as
> @@ -26,6 +27,10 @@
>  #include <ofono/log.h>
>  #include <ofono/modem.h>
>  #include <ofono/voicecall.h>
> +#include <src/common.h>
> +#include <ell/ell.h>
> +
> +#include "voice.h"
> 
>  #include "qmi.h"
> 
> @@ -35,8 +40,474 @@ struct voicecall_data {
>  	struct qmi_service *voice;
>  	uint16_t major;
>  	uint16_t minor;
> +	struct l_queue *call_list;
> +	struct ofono_phone_number dialed;
> +};
> +
> +struct qmi_voice_all_call_status_ind {
> +	bool call_information_set;
> +	const struct qmi_voice_call_information *call_information;
> +	bool remote_party_number_set;
> +	uint8_t remote_party_number_size;
> +	const struct qmi_voice_remote_party_number_instance
> +		*remote_party_number[16];
>  };
> 
> +struct qmi_voice_call_information_instance {
> +	uint8_t id;
> +	uint8_t state;
> +	uint8_t type;
> +	uint8_t direction;
> +	uint8_t mode;
> +	uint8_t multipart_indicator;
> +	uint8_t als;
> +} __attribute__((__packed__));
> +
> +struct qmi_voice_call_information {
> +	uint8_t size;
> +	struct qmi_voice_call_information_instance instance[0];
> +} __attribute__((__packed__));
> +
> +struct qmi_voice_remote_party_number_instance {
> +	uint8_t call_id;
> +	uint8_t presentation_indicator;
> +	uint8_t number_size;
> +	char number[0];
> +} __attribute__((__packed__));
> +
> +struct qmi_voice_remote_party_number {
> +	uint8_t size;
> +	struct qmi_voice_remote_party_number_instance instance[0];
> +} __attribute__((__packed__));
> +
> +static int ofono_call_compare(const void *a, const void *b, void *data)
> +{
> +	const struct ofono_call *ca = a;
> +	const struct ofono_call *cb = b;
> +
> +	if (ca->id < cb->id)
> +		return -1;
> +
> +	if (ca->id > cb->id)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static bool ofono_call_compare_by_status(const void *a, const void *b)
> +{
> +	const struct ofono_call *call = a;
> +	int status = L_PTR_TO_INT(b);
> +
> +	return status == call->status;
> +}
> +
> +static bool ofono_call_compare_by_id(const void *a, const void *b)
> +{
> +	const struct ofono_call *call = a;
> +	unsigned int id = L_PTR_TO_UINT(b);
> +
> +	return (call->id == id);
> +}
> +
> +static void ofono_call_list_dial_callback(struct ofono_voicecall *vc,
> +						int call_id)
> +{
> +	struct ofono_call *call;
> +	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
> +	struct l_queue *call_list = vd->call_list;
> +	const struct ofono_phone_number *ph = &vd->dialed;
> +
> +	/* check if call_id already present */
> +	call = l_queue_find(call_list, ofono_call_compare_by_id,
> +				L_UINT_TO_PTR(call_id));
> +
> +	if (call)
> +		return;
> +
> +	call = l_new(struct ofono_call, 1);
> +	call->id = call_id;
> +
> +	memcpy(&call->called_number, ph, sizeof(*ph));
> +	call->direction = CALL_DIRECTION_MOBILE_ORIGINATED;
> +	call->status = CALL_STATUS_DIALING;
> +	call->type = 0; /* voice */
> +
> +	l_queue_insert(call_list, call, ofono_call_compare, NULL);
> +
> +	ofono_voicecall_notify(vc, call);
> +}
> +
> +static void ofono_call_list_notify(struct ofono_voicecall *vc,
> +					struct l_queue *calls)
> +{
> +	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
> +	struct l_queue *old_calls = vd->call_list;
> +	struct l_queue *new_calls = calls;
> +	struct ofono_call *new_call, *old_call;
> +	const struct l_queue_entry *old_entry, *new_entry;
> +
> +	uint loop_length =
> +		MAX(l_queue_length(old_calls), 
l_queue_length(new_calls));
> +
> +	old_entry = l_queue_get_entries(old_calls);
> +	new_entry = l_queue_get_entries(new_calls);
> +
> +	for (uint i = 0; i < loop_length; ++i) {
> +		old_call = old_entry ? old_entry->data : NULL;
> +		new_call = new_entry ? new_entry->data : NULL;
> +
> +		if (new_call && new_call->status == 
CALL_STATUS_DISCONNECTED) {
> +			ofono_voicecall_disconnected(
> +				vc, new_call->id,
> +				
OFONO_DISCONNECT_REASON_REMOTE_HANGUP, NULL);
> +
> +			l_queue_remove(calls, new_call);
> +			l_free(new_call);
> +			continue;
> +		}
> +
> +		if (old_call &&
> +		    (new_call == NULL || (new_call->id > old_call->id)))
> +			ofono_voicecall_disconnected(
> +				vc, old_call->id,
> +				
OFONO_DISCONNECT_REASON_REMOTE_HANGUP, NULL);
> +		else if (new_call &&
> +			 (old_call == NULL || (new_call->id < 
old_call->id))) {
> +			DBG("Notify new call %d", new_call->id);
> +			/* new call, signal it */
> +			if (new_call->type == 0)
> +				ofono_voicecall_notify(vc, 
new_call);
> +		} else if (memcmp(new_call, old_call, sizeof(*new_call)) 
&&
> +				new_call->type == 0)
> +			ofono_voicecall_notify(vc, new_call);
> +
> +		if (old_entry)
> +			old_entry = old_entry->next;
> +		if (new_entry)
> +			new_entry = new_entry->next;
> +	}
> +
> +	l_queue_destroy(old_calls, l_free);
> +	vd->call_list = calls;
> +}
> +
> +static const char *qmi_voice_call_state_name(enum qmi_voice_call_state
> value) +{
> +	switch (value) {
> +	case QMI_VOICE_CALL_STATE_IDLE:
> +		return "QMI_VOICE_CALL_STATE_IDLE";
> +	case QMI_VOICE_CALL_STATE_ORIG:
> +		return "QMI_VOICE_CALL_STATE_ORIG";
> +	case QMI_VOICE_CALL_STATE_INCOMING:
> +		return "QMI_VOICE_CALL_STATE_INCOMING";
> +	case QMI_VOICE_CALL_STATE_CONV:
> +		return "QMI_VOICE_CALL_STATE_CONV";
> +	case QMI_VOICE_CALL_STATE_CC_IN_PROG:
> +		return "QMI_VOICE_CALL_STATE_CC_IN_PROG";
> +	case QMI_VOICE_CALL_STATE_ALERTING:
> +		return "QMI_VOICE_CALL_STATE_ALERTING";
> +	case QMI_VOICE_CALL_STATE_HOLD:
> +		return "QMI_VOICE_CALL_STATE_HOLD";
> +	case QMI_VOICE_CALL_STATE_WAITING:
> +		return "QMI_VOICE_CALL_STATE_WAITING";
> +	case QMI_VOICE_CALL_STATE_DISCONNECTING:
> +		return "QMI_VOICE_CALL_STATE_DISCONNECTING";
> +	case QMI_VOICE_CALL_STATE_END:
> +		return "QMI_VOICE_CALL_STATE_END";
> +	case QMI_VOICE_CALL_STATE_SETUP:
> +		return "QMI_VOICE_CALL_STATE_SETUP";
> +	}
> +	return "QMI_CALL_STATE_<UNKNOWN>";
> +}
> +
> +static bool qmi_to_ofono_status(uint8_t status, int *ret)
> +{
> +	int err = false;
> +
> +	switch (status) {
> +	case QMI_VOICE_CALL_STATE_IDLE:
> +	case QMI_VOICE_CALL_STATE_END:
> +	case QMI_VOICE_CALL_STATE_DISCONNECTING:
> +		*ret = CALL_STATUS_DISCONNECTED;
> +		break;
> +	case QMI_VOICE_CALL_STATE_HOLD:
> +		*ret = CALL_STATUS_HELD;
> +		break;
> +	case QMI_VOICE_CALL_STATE_WAITING:
> +		*ret = CALL_STATUS_WAITING;
> +		break;
> +	case QMI_VOICE_CALL_STATE_ORIG:
> +		*ret = CALL_STATUS_DIALING;
> +		break;
> +	case QMI_VOICE_CALL_STATE_SETUP:
> +	case QMI_VOICE_CALL_STATE_INCOMING:
> +		*ret = CALL_STATUS_INCOMING;
> +		break;
> +	case QMI_VOICE_CALL_STATE_CONV:
> +		*ret = CALL_STATUS_ACTIVE;
> +		break;
> +	case QMI_VOICE_CALL_STATE_CC_IN_PROG:
> +		*ret = CALL_STATUS_DIALING;
> +		break;
> +	case QMI_VOICE_CALL_STATE_ALERTING:
> +		*ret = CALL_STATUS_ALERTING;
> +		break;
> +	default:
> +		err = true;
> +	}
> +	return err;
> +}
> +
> +static uint8_t ofono_to_qmi_direction(enum call_direction ofono_direction)
> +{
> +	return ofono_direction + 1;
> +}
> +
> +static enum call_direction qmi_to_ofono_direction(uint8_t qmi_direction)
> +{
> +	return qmi_direction - 1;
> +}
> +
> +static int qmi_voice_call_status(struct qmi_result *qmi_result,
> +					struct 
qmi_voice_all_call_status_ind *result)
> +{
> +	int offset;
> +	uint16_t len;
> +	bool status = true;
> +	const struct qmi_voice_remote_party_number *remote_party_number;
> +	const struct qmi_voice_call_information *call_information;
> +
> +	static const uint8_t QMI_VOICE_ALL_CALL_STATUS_CALL_INFORMATION = 
0x01;
> +	static const uint8_t QMI_VOICE_ALL_CALL_STATUS_REMOTE_NUMBER = 
0x10;
> +	static const uint8_t QMI_VOICE_ALL_CALL_INFO_CALL_INFORMATION = 
0x10;
> +	static const uint8_t QMI_VOICE_ALL_CALL_INFO_REMOTE_NUMBER = 0x11;
> +
> +	/* mandatory */
> +	call_information = qmi_result_get(
> +		qmi_result, QMI_VOICE_ALL_CALL_STATUS_CALL_INFORMATION, 
&len);
> +
> +	if (!call_information) {
> +		call_information = qmi_result_get(
> +			qmi_result, 
QMI_VOICE_ALL_CALL_INFO_CALL_INFORMATION,
> +			&len);
> +		status = false;
> +	}
> +
> +	if (call_information) {
> +		/* verify the length */
> +		if (len < sizeof(call_information->size))
> +			return -EMSGSIZE;
> +
> +		if (len !=
> +			call_information->size *
> +			sizeof(struct 
qmi_voice_call_information_instance) +
> +			sizeof(call_information->size))
> +			return -EMSGSIZE;
> +
> +		result->call_information_set = 1;
> +		result->call_information = call_information;
> +	} else
> +		return -EBADMSG;
> +
> +	/* mandatory */
> +	remote_party_number = qmi_result_get(
> +		qmi_result,
> +		status ? QMI_VOICE_ALL_CALL_STATUS_REMOTE_NUMBER :
> +			 QMI_VOICE_ALL_CALL_INFO_REMOTE_NUMBER,
> +		&len);
> +
> +	if (remote_party_number) {
> +		const struct qmi_voice_remote_party_number_instance 
*instance;
> +		int instance_size =
> +			sizeof(struct 
qmi_voice_remote_party_number_instance);
> +		int i;
> +
> +		/* verify the length */
> +		if (len < sizeof(remote_party_number->size))
> +			return -EMSGSIZE;
> +
> +		for (i = 0, offset = sizeof(remote_party_number->size);
> +			offset <= len && i < 16 && i < 
remote_party_number->size;
> +			i++) {
> +			if (offset == len)
> +				break;
> +			else if (offset + instance_size > len)
> +				return -EMSGSIZE;
> +
> +			instance = (void *)remote_party_number + 
offset;
> +			result->remote_party_number[i] = instance;
> +			offset +=
> +				sizeof(struct 
qmi_voice_remote_party_number_instance) +
> +				instance->number_size;
> +		}
> +		result->remote_party_number_set = 1;
> +		result->remote_party_number_size = remote_party_number-
>size;
> +	} else
> +		return -EBADMSG;
> +
> +	return 0;
> +}
> +
> +static void all_call_status_ind(struct qmi_result *result, void *user_data)
> +{
> +	struct ofono_voicecall *vc = user_data;
> +	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
> +	struct l_queue *calls = l_queue_new();
> +	int i;
> +	int size = 0;
> +	struct qmi_voice_all_call_status_ind status_ind;
> +
> +	DBG("");
> +	if (qmi_voice_call_status(result, &status_ind) != 0) {
> +		DBG("Parsing of all call status indication failed");
> +		goto error;
> +	}
> +
> +	if (!status_ind.remote_party_number_set ||
> +	    !status_ind.call_information_set) {
> +		DBG("Some required fields are not set");
> +		goto error;
> +	}
> +
> +	size = status_ind.call_information->size;
> +	if (!size) {
> +		DBG("No call informations received!");
> +		goto error;
> +	}
> +
> +	/* expect we have valid fields for every call */
> +	if (size != status_ind.remote_party_number_size) {
> +		DBG("Not all fields have the same size");
> +		goto error;
> +	}
> +
> +	for (i = 0; i < size; i++) {
> +		struct qmi_voice_call_information_instance call_info;
> +		struct ofono_call *call;
> +		const struct qmi_voice_remote_party_number_instance
> +			*remote_party = 
status_ind.remote_party_number[i];
> +		int number_size;
> +
> +		call_info = status_ind.call_information->instance[i];
> +		call = l_new(struct ofono_call, 1);
> +		call->id = call_info.id;
> +		call->direction = 
qmi_to_ofono_direction(call_info.direction);
> +
> +		if (qmi_to_ofono_status(call_info.state, &call->status)) 
{
> +			DBG("Ignore call id %d, because can not 
convert QMI state 0x%x to
> ofono.", +				call_info.id, call_info.state);
> +			l_free(call);
> +			continue;
> +		}
> +		DBG("Call %d in state %s(%d)", call_info.id,
> +			qmi_voice_call_state_name(call_info.state),
> +			call_info.state);
> +
> +		call->type = 0; /* always voice */
> +		number_size = remote_party->number_size + 1;
> +		if (number_size > OFONO_MAX_PHONE_NUMBER_LENGTH)
> +			number_size = OFONO_MAX_PHONE_NUMBER_LENGTH;
> +		l_strlcpy(call->phone_number.number, remote_party-
>number,
> +				number_size);
> +
> +		if (strlen(call->phone_number.number) > 0)
> +			call->clip_validity = 0;
> +		else
> +			call->clip_validity = 2;
> +
> +		l_queue_push_tail(calls, call);
> +		DBG("%d", l_queue_length(calls));
> +	}
> +
> +	ofono_call_list_notify(vc, calls);
> +
> +	return;
> +error:
> +	l_queue_destroy(calls, l_free);
> +}
> +
> +static void dial_cb(struct qmi_result *result, void *user_data)
> +{
> +	struct cb_data *cbd = user_data;
> +	struct ofono_voicecall *vc = cbd->user;
> +	ofono_voicecall_cb_t cb = cbd->cb;
> +	uint16_t error;
> +	uint8_t call_id;
> +	bool call_id_set = false;
> +
> +	static const uint8_t QMI_VOICE_DIAL_RESULT_CALL_ID = 0x10;
> +
> +	DBG("");
> +
> +	if (qmi_result_set_error(result, &error)) {
> +		DBG("QMI Error %d", error);
> +		CALLBACK_WITH_FAILURE(cb, cbd->data);
> +		return;
> +	}
> +
> +	if (qmi_result_get_uint8(result, QMI_VOICE_DIAL_RESULT_CALL_ID,
> +					&call_id))
> +		call_id_set = true;
> +	else {
> +		DBG("Received invalid Result");
> +		CALLBACK_WITH_FAILURE(cb, cbd->data);
> +		return;
> +	}
> +
> +	if (!call_id_set) {
> +		DBG("Didn't receive a call id");
> +		CALLBACK_WITH_FAILURE(cb, cbd->data);
> +		return;
> +	}
> +
> +	DBG("New call QMI id %d", call_id);
> +	ofono_call_list_dial_callback(vc, call_id);
> +
> +	CALLBACK_WITH_SUCCESS(cb, cbd->data);
> +}
> +
> +static void dial(struct ofono_voicecall *vc,
> +			const struct ofono_phone_number *ph,
> +			enum ofono_clir_option clir, 
ofono_voicecall_cb_t cb,
> +			void *data)
> +{
> +	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
> +	struct cb_data *cbd = cb_data_new(cb, data);
> +	struct qmi_param *param;
> +	const char *calling_number = phone_number_to_string(ph);
> +
> +	static const uint8_t QMI_VOICE_DIAL_CALL_NUMBER = 0x01;
> +	static const uint8_t QMI_VOICE_DIAL_CALL_TYPE = 0x10;
> +	static const uint8_t QMI_VOICE_CALL_TYPE_VOICE = 0x00;
> +
> +	DBG("");
> +
> +	cbd->user = vc;
> +	memcpy(&vd->dialed, ph, sizeof(*ph));
> +
> +	param = qmi_param_new();
> +	if (!param)
> +		goto error;
> +
> +	if (!qmi_param_append(param, QMI_VOICE_DIAL_CALL_NUMBER,
> +				strlen(calling_number), 
calling_number)) {
> +		goto error;
> +	}
> +
> +	qmi_param_append_uint8(param, QMI_VOICE_DIAL_CALL_TYPE,
> +				QMI_VOICE_CALL_TYPE_VOICE);
> +
> +	if (qmi_service_send(vd->voice, QMI_VOICE_DIAL_CALL, param, 
dial_cb,
> +				cbd, l_free) > 0)
> +		return;
> +
> +error:
> +	CALLBACK_WITH_FAILURE(cb, data);
> +	l_free(cbd);
> +	l_free(param);
> +}
> +
>  static void create_voice_cb(struct qmi_service *service, void *user_data)
>  {
>  	struct ofono_voicecall *vc = user_data;
> @@ -58,6 +529,9 @@ static void create_voice_cb(struct qmi_service *service,
> void *user_data)
> 
>  	data->voice = qmi_service_ref(service);
> 
> +	qmi_service_register(data->voice, QMI_VOICE_ALL_CALL_STATUS_IND,
> +			     all_call_status_ind, vc, NULL);
> +
>  	ofono_voicecall_register(vc);
>  }
> 
> @@ -70,6 +544,7 @@ static int qmi_voicecall_probe(struct ofono_voicecall
> *vc, DBG("");
> 
>  	data = l_new(struct voicecall_data, 1);
> +	data->call_list = l_queue_new();
> 
>  	ofono_voicecall_set_data(vc, data);
> 
> @@ -77,7 +552,6 @@ static int qmi_voicecall_probe(struct ofono_voicecall
> *vc, create_voice_cb, vc, NULL);
> 
>  	return 0;
> -
>  }
> 
>  static void qmi_voicecall_remove(struct ofono_voicecall *vc)
> @@ -92,13 +566,16 @@ static void qmi_voicecall_remove(struct ofono_voicecall
> *vc)
> 
>  	qmi_service_unref(data->voice);
> 
> +	l_queue_destroy(data->call_list, l_free);
>  	l_free(data);
>  }
> 
>  static const struct ofono_voicecall_driver driver = {
>  	.probe		= qmi_voicecall_probe,
>  	.remove		= qmi_voicecall_remove,
> +	.dial		= dial,
>  };
> 
>  OFONO_ATOM_DRIVER_BUILTIN(voicecall, qmimodem, &driver)
> 
> +




