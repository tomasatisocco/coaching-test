import 'package:coaching/l10n/l10n.dart';
import 'package:flutter/material.dart';

class QuestionModel {
  const QuestionModel({
    required this.question,
    required this.description,
    Map<String, int>? answers,
    required this.key,
    this.image,
  }) : answers = answers ??
            const <String, int>{
              '0': 0,
              '1': 1,
              '2': 2,
              '3': 3,
              '4': 4,
            };

  final String question;
  final String description;
  final Map<String, int> answers;
  final Image? image;
  final String key;
}

List<QuestionModel> getQuestions(AppLocalizations l10n) {
  return <QuestionModel>[
    // Part 1 - Quality of Service
    QuestionModel(
      question: l10n.question101,
      description: l10n.question101Description,
      key: '101',
    ),
    QuestionModel(
      question: l10n.question102,
      description: l10n.question102Description,
      answers: {
        '0%': 0,
        l10n.between1to4: 3,
        l10n.between5to10: 3,
        l10n.between11to20: 6,
        l10n.between21to30: 9,
        l10n.moreThan30: 12,
      },
      key: '102',
    ),
    QuestionModel(
      question: l10n.question103,
      description: l10n.question103Description,
      answers: {
        '0%': 0,
        '10%': 1,
        '25%': 2,
        '50%': 3,
        l10n.byOrder: 4,
      },
      key: '103',
    ),
    QuestionModel(
      question: l10n.question104,
      description: l10n.question104Description,
      key: '104',
    ),
    QuestionModel(
      question: l10n.question105,
      description: l10n.question105Description,
      answers: {
        '0': 0,
        '1': 3,
        '2': 6,
        l10n.between3to5: 9,
        l10n.moreThan5: 12,
      },
      key: '105',
    ),
    QuestionModel(
      question: l10n.question106,
      description: l10n.question106Description,
      answers: {
        l10n.no: 0,
        l10n.yes: 1,
      },
      key: '106',
    ),
    QuestionModel(
      question: l10n.question107,
      description: l10n.question107Description,
      answers: {
        l10n.no: 0,
        l10n.yes: 1,
      },
      key: '107',
    ),
    QuestionModel(
      question: l10n.question108,
      description: l10n.question108Description,
      key: '108',
    ),
    QuestionModel(
      question: l10n.question109,
      description: l10n.question109Description,
      answers: {
        l10n.noOfferProcess: 0,
        l10n.offerProcessExceptionally: 1,
        l10n.offerProcessFrequently: 3,
        l10n.offerProcessAlways: 5,
        l10n.offerProcessExclusively: 9,
      },
      key: '109',
    ),
    QuestionModel(
      question: l10n.question110,
      description: l10n.question110Description,
      key: '110',
    ),
    // Part 2 - Business Creation
    QuestionModel(
      question: l10n.question201,
      description: l10n.question201Description,
      answers: {
        '0%': 0,
        l10n.between1to25: 1,
        l10n.between26to50: 2,
        l10n.between51to75: 3,
        l10n.between76to100: 4,
      },
      key: '201',
    ),
    QuestionModel(
      question: l10n.question202,
      description: l10n.question202Description,
      answers: {
        l10n.notPaymentYet: 0,
        l10n.between1to10: 1,
        l10n.between11to20: 2,
        l10n.between21to30: 3,
        l10n.moreThan30: 4,
      },
      key: '202',
    ),
    QuestionModel(
      question: l10n.question203,
      description: l10n.question203Description,
      answers: {
        '0': 0,
        l10n.between1to999: 5,
        l10n.between1000to1999: 10,
        l10n.between2000to2999: 15,
        l10n.moreThan3000: 20,
      },
      key: '203',
    ),
    QuestionModel(
      question: l10n.question204,
      description: l10n.question204Description,
      answers: {
        l10n.any: 0,
        l10n.lowPrices: 1,
        l10n.highPrices: 2,
        l10n.typeOfService: 3,
        l10n.onlyOne: 4,
        l10n.firstOne: 5,
        l10n.clientRelationship: 6,
        l10n.paymentMethod: 7,
      },
      key: '204',
    ),
    QuestionModel(
      question: l10n.question205,
      description: l10n.question205Description,
      key: '205',
    ),
    QuestionModel(
      question: l10n.question206,
      description: l10n.question206Description,
      key: '206',
    ),
    // Part 3 - Personal Wellness
    QuestionModel(
      question: l10n.question301,
      description: l10n.question301Description,
      key: '301',
    ),
    QuestionModel(
      question: l10n.question302,
      description: l10n.question302Description,
      key: '302',
    ),
    QuestionModel(
      question: l10n.question303,
      description: l10n.question303Description,
      key: '303',
    ),
    QuestionModel(
      question: l10n.question304,
      description: l10n.question304Description,
      key: '304',
    ),
    QuestionModel(
      question: l10n.question305,
      description: l10n.question305Description,
      key: '305',
    ),
    // Part 4 - Aport to the Community
    QuestionModel(
      question: l10n.question401,
      description: l10n.question401Description,
      key: '401',
    ),
    QuestionModel(
      question: l10n.question402,
      description: l10n.question402Description,
      key: '402',
    ),
    QuestionModel(
      question: l10n.question403,
      description: l10n.question403Description,
      answers: {
        '0': 0,
        '1': 3,
        '2': 6,
        '3': 9,
        '4': 12,
      },
      key: '403',
    ),
    QuestionModel(
      question: l10n.question404,
      description: l10n.question404Description,
      answers: {
        '0': 0,
        '1': 3,
        '2': 6,
        '3': 9,
        '4': 12,
      },
      key: '404',
    ),
  ];
}
